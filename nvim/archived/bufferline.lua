local status, bufferline = pcall(require, 'bufferline')
if not status then
	print('bufferline plugin not found!')
	return
end

bufferline.setup()
