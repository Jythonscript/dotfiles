function my_exit() {
	exit
}

function zvm_config() {
	ZVM_KEYTIMEOUT=0.04
}

function zvm_after_init() {
	[ -f ~/.oh-my-zsh/plugins/fzf/fzf.plugin.zsh ] && source ~/.oh-my-zsh/plugins/fzf/fzf.plugin.zsh

	zvm_define_widget vimbuffer

	zvm_bindkey viins '^P' vimbuffer
	zvm_bindkey viins '^Q' push-line
	zvm_bindkey viins '^H' backward-kill-word
	zvm_bindkey viins '^[.' insert-last-word
	zvm_bindkey viins '^[[Z' reverse-menu-complete
}

function zvm_after_lazy_keybindings() {
	zvm_define_widget my_exit
	zvm_bindkey vicmd 'ZZ' my_exit
	zvm_bindkey vicmd 'ZQ' my_exit
	zvm_bindkey vicmd ',q' my_exit
	zvm_bindkey vicmd ',w' accept-line
}
