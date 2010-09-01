 module PublicHelper
  
  def children_nested(pages)
    returning "" do |html|
    unless pages.empty?
        html << "<ul>"
        pages.each do |page|     
           if page.child?  
              html << "<li>"
            html << "#{link_to_unless_current( page.navlabel, view_page_path(page.name))}"
          end
         html << "</li>"
        end
        html << "</ul>"
    end
    end
  end
  def siblings_nested(pages) 
    returning "" do |html|      
      unless pages.empty?
        html << "<ul>"
        pages.each do |page|     
           if page.child?  
            html << "<li>"
            html << "#{link_to_unless_current( page.navlabel, view_page_path(page.name))}"
          end
         html << "</li>"
        end
        html << "</ul>"
    end
    end
  end
  
  def public_nested(pages)
    returning "" do |html|
      unless pages.empty?
        pages.each do |page|
           if !page.child?
           html << "<li>#{link_to_unless_current(page.navlabel, view_page_path(page.name))}"  
           end
            
      end
      end
    end
  end
  
  def link_to_unless_current_or_child(page)
    if current_page == page or page.childeren
      link_to(page.navlabel, view_page_path(page.name))
    end
    
  end
end
