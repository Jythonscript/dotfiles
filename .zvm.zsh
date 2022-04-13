ZVM_KEYTIMEOUT=0.04

function zvm_after_init() {
	[ -f ~/.oh-my-zsh/plugins/fzf/fzf.plugin.zsh ] && source ~/.oh-my-zsh/plugins/fzf/fzf.plugin.zsh

	zvm_define_widget vimbuffer
	zvm_bindkey viins '^P' vimbuffer
	zvm_bindkey viins '^Q' push-line
	zvm_bindkey viins '^H' backward-kill-word
}

function zvm_after_lazy_keybindings() {
}
