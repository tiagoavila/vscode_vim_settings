local vscode = require("vscode")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Code navigation
keymap({"n", "v"}, "<leader>ff", function() vscode.action('editor.action.quickFix') end, opts)
keymap({"n", "v"}, "gq", function() vscode.action('editor.action.quickFix') end, opts)
keymap({"n", "v"}, "gi", function() vscode.action('editor.action.goToImplementation') end, opts)
keymap({"n", "v"}, "gpi", function() vscode.action('editor.action.peekImplementation') end, opts)
keymap({"n", "v"}, "gr", function() vscode.action('editor.action.referenceSearch.trigger') end, opts)

keymap({"n", "v"}, '<leader>fd', function() vscode.action('editor.action.formatDocument') end, opts)

-- Breakpoint operations (b prefix)
keymap({"n", "v"}, "<leader>bt", function() vscode.action('editor.debug.action.toggleBreakpoint') end, opts)
keymap({"n", "v"}, "<leader>bra", function() vscode.action('workbench.debug.viewlet.action.removeAllBreakpoints') end, opts)
keymap({"n", "v"}, "<leader>be", function() vscode.action('editor.debug.action.editBreakpoint') end, opts)

-- Debug operations (d prefix)
keymap({"n", "v"}, "<leader>ds", function() vscode.action('workbench.action.debug.start') end, opts)
keymap({"n", "v"}, "<leader>dw", function() vscode.action('editor.debug.action.selectionToWatch') end, opts)

-- View operations (v prefix)
keymap({"n", "v"}, "<leader>vp", function() vscode.action('workbench.actions.view.problems') end, opts)
keymap({"n", "v"}, "<leader>ve", function() vscode.action('workbench.view.explorer') end, opts)
keymap({"n", "v"}, "<leader>vc", function() vscode.action('workbench.view.scm') end, opts)
keymap({"n", "v"}, "<leader>vt", function() vscode.action('workbench.action.terminal.toggleTerminal') end, opts)

-- File operations (f prefix)  
keymap({"n", "v"}, "<leader>fs", function() vscode.action('workbench.action.findInFiles') end, opts)
keymap({"n", "v"}, "<leader>fr", function() vscode.action('workbench.action.replaceInFiles') end, opts)

-- Tab navigation (t prefix)
keymap({"n", "v"}, '<leader>tp', function() vscode.action('workbench.action.previousEditor') end, opts)
keymap({"n", "v"}, '<leader>tn', function() vscode.action('workbench.action.nextEditor') end, opts)
keymap({"n", "v"}, "<leader>tf", function() vscode.action('workbench.action.firstEditorInGroup') end, opts)
keymap({"n", "v"}, "<leader>tl", function() vscode.action('workbench.action.lastEditorInGroup') end, opts)

-- Rename and refactor
keymap({"n", "v"}, "<leader>rn", function() vscode.action('editor.action.rename') end, opts)
keymap({"n", "v"}, "<leader>rr", function() vscode.action('editor.action.refactor') end, opts)

-- Editor management (e prefix)
keymap({"n", "v"}, "<leader>esr", function() vscode.action('workbench.action.splitEditorRight') end, opts)
keymap({"n", "v"}, "<leader>esl", function() vscode.action('workbench.action.focusLeftGroup') end, opts)
keymap({"n", "v"}, "<leader>emr", function() vscode.action('workbench.action.moveEditorToRightGroup') end, opts)
keymap({"n", "v"}, "<leader>eml", function() vscode.action('workbench.action.moveEditorToLeftGroup') end, opts)
keymap({"n", "v"}, "<leader>efr", function() vscode.action('workbench.action.focusRightGroup') end, opts)
keymap({"n", "v"}, "<leader>efl", function() vscode.action('workbench.action.focusLeftGroup') end, opts)


-- zc = fold
keymap("n", "zc", function() vscode.action("editor.fold") end, opts)

-- zo = unfold
keymap("n", "zo", function() vscode.action("editor.unfold") end, opts)
