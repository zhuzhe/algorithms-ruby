require 'nokogiri'
require 'open-uri'


(1..18).each do |i|
	file = File.new("./company#{i}", 'w')
	doc = Nokogiri::HTML(open("https://m.11467.com/mip/chengdu/dir/k722.htm"))
	if i > 1
		doc = Nokogiri::HTML(open("https://m.11467.com/mip/chengdu/dir/k722-p#{i}.htm"))
	end
	doc.css('.companylist li').each do |li|
		begin
			sleep 2
			# 公司详细页面链接
			a = li.css('a').first
			next unless a
			line = []
			if a
				# 链接地址
				detail_a = a.attributes['href'].value
				p detail_a
				detail_doc = Nokogiri::HTML(open(detail_a))
				# 公司名字
				line << detail_doc.css('#main .boxtitle .navleft').text
				# 公司地址
				line << detail_doc.css('#main .boxcontent dd')[0].text
				# phone
				line << detail_doc.css('#main .boxcontent dd')[1].text
				# 董事长
				line << detail_doc.css('#main .boxcontent dd')[2].text
				# 董事长手机
				line << detail_doc.css('#main .boxcontent dd')[3].text
				# 经营状态
				detail_doc.css('#gongshang  dt').each do |dt|
					if dt.text.match('经营状态')
						line << dt.next_sibling.text
					end
				end
			end
			line.each do |elem|
				elem.gsub!(' ', '')
			end
			p line
			file << line.join('      ')
			file << "\n"
		rescue Exception => e
			p e
		end
	end
	file.close
end




