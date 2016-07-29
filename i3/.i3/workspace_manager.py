#!/usr/bin/env python3
import json
import argparse
import subprocess

# Workspaces are separated into groups of 10
# and navigation happens around those groups
WORKSPACE_GROUP = 0
WORKSPACES = {}
NEXTS = [[] for _ in range(10)]
TREE = None
ASSIGNS = {
    6: 'Steam',
}

def main():
    parser = get_parser()
    args = parser.parse_args()
    initialise_workspaces()

    if args.go_left:
        i3_go_left()
    elif args.go_right:
        i3_go_right()
    elif args.go_up:
        i3_go_up()
    elif args.go_down:
        i3_go_down()
    elif args.move_to:
        i3_move_to(args.move_to)
    elif args.move_left:
        i3_move_left()
    elif args.move_right:
        i3_move_right()
    elif args.move_up:
        i3_move_up()
    elif args.move_down:
        i3_move_down()
    elif args.move_output_left:
        i3_move_output_left()
    elif args.move_output_right:
        i3_move_output_right()
    elif args.goto_number:
        i3_goto_workspace_group_number(args.goto_number)
    elif args.rename:
        i3_rename_current_workspace(args.rename)

def get_parser():
    parser = argparse.ArgumentParser(description='i3-wm workspace manager')
    parser.add_argument('--goto-number', type=int, help='Goto Workspace #N')
    parser.add_argument('--goto', type=str, help='Goto Workspace')
    parser.add_argument('--rename', type=str, help='Rename Current Workspace')
    parser.add_argument('--go-left', action='store_true', help='Move to previous workspace')
    parser.add_argument('--go-right', action='store_true', help='Move to next workspace')
    parser.add_argument('--go-up', action='store_true', help='Move to next workspace group')
    parser.add_argument('--go-down', action='store_true', help='Move to previous workspace group')
    parser.add_argument('--move-to', type=int, help='Move container to workspace group id')
    parser.add_argument('--move-left', action='store_true', help='Move container left')
    parser.add_argument('--move-right', action='store_true', help='Move container right')
    parser.add_argument('--move-up', action='store_true', help='Move container up')
    parser.add_argument('--move-down', action='store_true', help='Move container down')
    parser.add_argument('--move-output-left', action='store_true', help='Move to left output')
    parser.add_argument('--move-output-right', action='store_true', help='Move to right output')
    return parser

def initialise_workspaces():
    global WORKSPACES, WORKSPACE_GROUP, NEXTS, TREE

    for w in json_get_workspaces():
        n = w['num']
        name = w['name']

        grp = (n - 1) // 10
        base = n % 10
        NEXTS[base].append(grp)

        WORKSPACES[n] = {'name': name, 'grp': grp, 'base': base}

        if n in ASSIGNS:
            assign(ASSIGNS[n], name)

    TREE = i3_cmd(['-t', 'get_tree'])
    cur = json_get_current_workspace()
    WORKSPACE_GROUP = (cur['num'] - 1) // 10

def assign(c, workspace):
    i3_cmd(['exec assign [class="{}"] workspace {}'.format(c, workspace)])

def json_get_workspaces():
    return i3_cmd(['-t', 'get_workspaces'])

def json_get_current_workspace():
    for w in i3_cmd(['-t', 'get_workspaces']):
        if w['focused']:
            return w

def i3_move_left():
    i3_move_by(-1)

def i3_move_up():
    i3_move_by(10)

def i3_move_down():
    i3_move_by(-10)

def i3_move_right():
    i3_move_by(1)

def i3_move_by(n):
    cur = json_get_current_workspace()
    n = cur['num'] + n

    if n < 1:
        return

    if n in WORKSPACES:
        n = WORKSPACES[n]['name']

    i3_cmd(['move container to workspace {}'.format(n)])
    i3_cmd(['workspace {}'.format(n)])

def i3_move_to(n):
    n = 10 * WORKSPACE_GROUP + n
    i3_cmd(['move container to workspace number {}'.format(n)])
    i3_cmd(['workspace {}'.format(n)])

def i3_go_left():
    global WORKSPACE_GROUP
    cur = json_get_current_workspace()
    n = cur['num'] - 1

    if n < WORKSPACE_GROUP * 10:
        WORKSPACE_GROUP -= 1

    if n > 0:
        i3_goto_workspace_number(n)

def i3_go_right():
    global WORKSPACE_GROUP
    cur = json_get_current_workspace()
    n = cur['num'] + 1

    if n > WORKSPACE_GROUP * 10:
        WORKSPACE_GROUP += 1

    i3_goto_workspace_number(n)

def i3_go_up():
    global WORKSPACE_GROUP
    cur = json_get_current_workspace()
    n = cur['num']

    WORKSPACE_GROUP += 1
    i3_goto_workspace_number(n + 10)

def i3_go_down():
    global WORKSPACE_GROUP
    cur = json_get_current_workspace()
    n = cur['num']

    if n < 10:
        return

    WORKSPACE_GROUP -= 1
    i3_goto_workspace_number(n - 10)

def i3_rename_current_workspace(name):
    global WORKSPACES
    cur = json_get_current_workspace()
    n = cur['num']

    if name.strip() == '':
        name = '{}'.format(n)
    else:
        name = '{} - {}'.format(n, name)

    WORKSPACES[n]['name'] = name
    i3_cmd(['rename workspace to "{}"'.format(name)])
    if n in ASSIGNS:
        assign(ASSIGNS[n], name)

def i3_goto_workspace(workspace):
    '''Goto a named i3 workspace
    '''
    return i3_cmd(['workspace {}'.format(workspace)])

def i3_move_output_right():
    return i3_cmd(['move workspace to output right'])

def i3_move_output_left():
    return i3_cmd(['move workspace to output left'])

def i3_goto_workspace_group_number(workspace):
    '''Goto a numbered i3 workspace
    '''
    # get current workspace
    cur = json_get_current_workspace()
    n = cur['num']

    wk = WORKSPACES[n]
    wk_base = wk['base']
    wk_grp = wk['grp']

    grp = 0

    # if on workspace 3 and press 3
    # always go to workspace 13
    if workspace == n:
        grp = 1
    # if on workspace 13 and press 3
    # go to 23 (or the next numbered)
    if workspace + wk_grp * 10 == n:
        nexts = NEXTS[wk_base]
        i = nexts.index(wk_grp) + 1
        i %= len(nexts)
        grp = nexts[i]

    return i3_cmd(['workspace number {}'.format(int(grp * 10 + workspace))])

def i3_goto_workspace_number(workspace):
    '''Goto a numbered i3 workspace
    '''
    return i3_cmd(['workspace number {}'.format(int(workspace))])

def i3_cmd(cmds):
    pipe = subprocess.Popen(["i3-msg", *cmds], stdout=subprocess.PIPE)
    out, *_ = pipe.communicate()
    data = json.loads(out.decode())
    return data

if __name__ == '__main__':
    main()
