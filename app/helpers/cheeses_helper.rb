module CheesesHelper

	def button_to_remove_process_record_field(f)
		f.hidden_field(:_destroy) +
		"<span class=\"input-group-btn\">
			<button class=\"btn btn-default\" onclick=\"#{escape_javascript("remove_field(this); return false;")}\" type=\"button\"><span class=\"glyphicon glyphicon-remove\"></span></button>
		</span>".html_safe
	end

	def button_to_add_field(name, f, association, function)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			p association.to_s.singularize + "_form"
			render(:partial => association.to_s.singularize + "_form", :locals => {:f => builder})
		end
		fields = fields.split("\n").join("").split("\t").join("")
		html = "#{function}(this, \'#{association}\', \'".html_safe
		html << escape_javascript(fields)
		html << "\'); return false;".html_safe
		button_to_function(name, html)
	end

	def button_to_add_field_process_record(name, f, association, function)
		new_object = f.object.class.reflect_on_association(association).klass.new
		new_object.build_process_type
		new_object.time_measures.build
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			p association.to_s.singularize + "_form"
			render(:partial => association.to_s.singularize + "_form", :locals => {:f => builder})
		end
		fields = fields.split("\n").join("").split("\t").join("")
		html = "#{function}(this, \'#{association}\', \'".html_safe
		html << escape_javascript(fields)
		html << "\'); return false;".html_safe
		button_to_function(name, html)
	end


	def button_to_function(name, function)
		content_tag(:button, name, :type => "button", :class => "btn btn-default pull-right", :onclick => function)
	end
end
