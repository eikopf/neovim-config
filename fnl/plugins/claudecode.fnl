;; coder/claudecode.nvim --- neovim integration for claude code

;; the commands bound in core/keymaps.fnl are all load triggers
{1 :coder/claudecode.nvim
 :opts {:terminal {:provider :native}}
 :cmd [:ClaudeCode
       :ClaudeCodeAdd
       :ClaudeCodeSend
       :ClaudeCodeFocus
       :ClaudeCodeSelectModel
       :ClaudeCodeDiffAccept
       :ClaudeCodeDiffDeny]}
