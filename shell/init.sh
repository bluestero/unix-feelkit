# feelkit's shell setup. The toolkit's shell/init.sh sources it (bash and zsh) before direnv,
# starship and the tools load. $_work_root is the toolkit's folder.
_fk="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")/.." && pwd)"
# k-bg keeps a copy of starship.toml with the background's accent colours in it;
# starship rereads it at every prompt, so a new background shows straight away.
_kbg_star="${XDG_STATE_HOME:-$HOME/.local/state}/k-bg/starship.toml"
# Its source: your starship.toml, or the toolkit's merge of it with your patch (shell/init.sh).
_kbg_src="$HOME/.local/state/work-toolkit/starship.toml"
[ -f "$_kbg_src" ] || _kbg_src="${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
if [ -f "$_kbg_star" ]; then
  [ "$_kbg_src" -nt "$_kbg_star" ] &&
    "$_fk/bin/k-bg" __sync_prompt 2>/dev/null
  export STARSHIP_CONFIG="$_kbg_star"
fi
unset _kbg_star _kbg_src
for _f in k-icon k-bg k-theme; do   # tab completion
  [ -r "$_fk/shell/$_f.sh" ] && . "$_fk/shell/$_f.sh"
done
unset _fk _f
