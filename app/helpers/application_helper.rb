module ApplicationHelper
	def key_code_field f=nil 
		keys = Key.all.map{|k| k.code}.uniq
		if f
			f.text_field :code, :"data-provide" => 'typeahead', :"data-items" => keys.length, :"data-source" => keys.to_s, :size => 4, :autocomplete => false, :placeholder => "Code engraved on key"
		else
			text_field_tag :key_code, nil, :"data-provide" => 'typeahead', :"data-items" => keys.length, :"data-source" => keys.to_s, :size => 1, :autocomplete => false, :placeholder => "Code engraved on key"
		end
	end

	def person_name_field
		keys = Person.all.map{|k| k.name}.uniq
		text_field_tag :name, nil, :"data-provide" => 'typeahead', :"data-items" => keys.length, :"data-source" => keys.to_s, :size => 1, :placeholder => "Who gets this key?"
	end

def twitterized_type(type)
  case type
    when :alert
      "warning"
    when :error
      "error"
    when :notice
      "info"
    when :success
      "success"
    else
      type.to_s
  end
end
	
end

