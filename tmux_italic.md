# Tmux Activate italics

1. Created `tmux-256color.terminfo`

```bash
# A tmux-256color based TERMINFO that adds the escape sequences for italic.
tmux-256color|screen with 256 colors and italic,
 sitm=\E[3m, ritm=\E[23m,
 use=screen-256color,
```

2. `tic tmux-256color.terminfo`
3. 'set -g default-terminal "tmux-256color"' in `.tmux.conf`
