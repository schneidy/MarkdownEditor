ActionView::Template.register_template_handler(:md, :source.to_proc)
ActionView::Template.register_template_handler(:markdown, :source.to_proc)