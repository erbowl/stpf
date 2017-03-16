module UsersHelper
  def age_arr
    return ["中学1年生"],["中学2年生"],["中学3年生"],["高校1年生"],["高校2年生"],["高校3年生"], ["浪人生"],["大学1年生"],["大学2年生"],["大学3年生"],["大学4年生"],["その他"]
  end
  def univ_arr
    return ["東京大学","一橋大学"]
  end
  def depa_arr
    return ["法学部","医学部"]
  end
  def depa_arr
    return ["法学部","医学部"]
  end
  
  def pro_row(label,name)
    value=@user[name]
    render :partial => "profile_row",:locals => { :label=>label,:value=>value,:name=>name} unless value.nil?
  end

  def top_button(array=[],css)
    opt=[]
    opt[0]=array
    opt[1]=css
    opt.inspect
  render :inline => <<-HAML, :type => :haml, :locals => {:opt => opt}
.btn-group.btn-group-justified{:role => "group"}
  - opt[0].each do |key,path|
    .btn-group{:role => "group"}
      %button.btn#{opt[1]}=link_to key,path,class:"active"
  HAML
  end

end
