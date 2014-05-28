module CheesesHelper

	def button_to_remove_process_record(f)
		f.hidden_field(:_destroy) +
		"<span class=\"input-group-btn\">
			<button class=\"btn btn-default\" onclick=\"#{escape_javascript("Cheeses.remove_field(this); return false;")}\" type=\"button\">
				<span class=\"glyphicon glyphicon-remove\">
				</span>
			</button>
		</span>".html_safe
	end
	
	def button_to_remove_time_measure(f)
		f.hidden_field(:_destroy) +
		"<div><button type=\"button\" class=\"btn btn-danger\" onclick=\"#{escape_javascript("Cheeses.remove_field(this); return false;")}\">
			<span class=\"glyphicon glyphicon-remove\" ></span>
		</button></div>".html_safe
	end

	def button_to_add_field_time_measure(name, f, association, function)
		button_to_add_field(name, f, association, function)
	end

	def button_to_add_field_process_record(name, f, association, function)
		button_to_add_field(name, f, association, function, {
			:process_type => {
				:num => 1
			},
			:time_measures => {
				:num => 1
			}
		})
	end

	#	button_to_add_field
	#		
	#		Add a button within html that will generate the form for the given
	#		association of the passed in form (f). Subforms for the associations
	#		will only be generated if they are specified in the "associations"
	#		hash, for how many time they are specified.
	#
	#		eg. associations = {
	#													:association_sym_1 => {
	#														:num => 1
	#													}
	#													:association_sym_2 => {
	#														:num => 2
	#													}
	#												}
	#
	def button_to_add_field(name, f, association, function, associations={})
		#some double checking should be done here for associations
		#that they conform to types
		#TODO
		new_object = f.object.class.reflect_on_association(association).klass.new
		has_many_associations = new_object.class.reflect_on_all_associations(:has_many)
		belongs_to_associations = new_object.class.reflect_on_all_associations(:belongs_to)
		has_many_associations.each do |a|
			if associations.has_key?(a.name)
				associations[a.name][:num].times do
					p "building #{a.name} #{associations[a.name][:num]} times"
					new_object.method(a.name).call.build
				end
			end
		end
		belongs_to_associations.each do |a|
			if associations.has_key?(a.name)
				p "building #{a.name} #{associations[a.name][:num]} times"
				new_object.method("build_"+(a.name.to_s)).call
			end
		end	
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(:partial => association.to_s.singularize + "_form", :locals => {:f => builder})
		end
		fields = fields.split("\n").join("").split("\t").join("")
		html = "Cheeses.#{function}(this, \'#{association}\', \'".html_safe
		html << escape_javascript(fields)
		html << "\'); return false;".html_safe
		button_to_function(name, html)
	end

	def button_to_function(name, function)
		content_tag(:button, name, :type => "button", :class => "btn btn-default pull-right", :onclick => function)
	end
end
