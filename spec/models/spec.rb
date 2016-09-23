  describe 'Download file' do
		
    specify do
      visit '/createfile'
 			#save_and_open_page
			
      click_on 'create file'
			
			
      #expect( DownloadHelpers::download_content ).to include email_csv
      #expect( DownloadHelpers::download_content ).to include temp.txt
			#expect(DownloadHelpers::download_content).to have_content('temp.txt')
			page.response_headers['Content-Type'].should == "text/lfile"
			#expect page.response_headers['Content-Type'] == "texts/lfile"
			
			page.status_code.should == 200
			#page.response_headers['Content-Type'].must_equal "text/lfile"
			#page.response_headers['Content-Disposition'].should == "attachment; filename=\"temp.txt\""
			header = page.response_headers['Content-Disposition']
			header.should match /^attachment/
			header.should match /filename=\"temp.txt\"$/
			#puts page.html
			#page.body.has_content? "sudo"
			#visit a_path
			#expect(page).to have_text("Login successful.")
			#page.must_has_content "Schubidu"
  		#page.must_have_content "U13"
  		#page.wont_have_content "5000"
			#page.should match "sudo"
			#expect(page).to have_http_status(:success)
    end
	end