local blankline_status, blankline = pcall(require, 'indent_blankline')
if not blankline_status then
	print('blankline plugin not found!')
	return
end

blankline.setup{
	char = '┊',
	show_current_context = true,
	show_current_context_start = true,
}
