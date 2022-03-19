module DashboardHelper

    
    def current_class?(test_path)
        if current_page?(test_path)
        return "'active'"
        else
        return ''
        end
    end

end
