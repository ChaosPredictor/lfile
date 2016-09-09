module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		base_title = "Linux Apps Installer"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end
	
	def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
	
	def current_page
		current_uri = request.env['PATH_INFO']
		if current_uri == "/help"
			@current_page = "help"
		elsif current_uri == "/about"
			@current_page = "about"
		elsif current_uri == "/contact"
			@current_page = "contact"	
		elsif current_uri == "/createfile"
			@current_page = "createfile"	
		end
	end
end
