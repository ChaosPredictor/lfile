  describe 'Download file' do
 
    specify do
      visit '/createfile'
 			#save_and_open_page
			
      click_on 'create file'
			
			
      #expect( DownloadHelpers::download_content ).to include email_csv
      #expect( DownloadHelpers::download_content ).to include temp.txt
			#expect(DownloadHelpers::download_content).to have_content('temp.txt')
			page.response_headers['Content-Type'].should == "text/lfile"
			#page.response_headers['Content-Disposition'].should == "attachment; filename=\"temp.txt\""
			header = page.response_headers['Content-Disposition']
			header.should match /^attachment/
			header.should match /filename=\"temp.txt\"$/
			expect(page).to have_http_status(:success)
    end
	end