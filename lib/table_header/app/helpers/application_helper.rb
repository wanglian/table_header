module TableHeader
  module App
    module Helpers
      module ApplicationHelper
      
        def self.included(base)
          base.class_eval do
            include InstanceMethods
          end
        end
        
        module InstanceMethods
          def selectable_table_header(opts = {})
            raise ArgumentError if opts[:name].nil?
            anchor = opts[:anchor].blank? ? "" : "##{opts[:anchor]}"
            content_tag :th, 
              select_tag('', "<option value=""></option>#{options_for_select(opts[:collection], params[opts[:name]])}", :onchange => "window.location='#{selectable_url(opts[:name])}&#{opts[:name]}=' + this.value"),
              :class => class_name_for_sortable_table_header_tag(opts)
          end

          def selectable_url(name)
            url_for(params.merge(name => nil).reverse_merge(:page => 1))
          end
          
          def filter_table_header(name, opts={})
            text_field_tag(name, params[name], opts.merge(:onchange => "window.location='#{filter_url(name)}&#{name}=' + this.value"))
          end
          
          def filter_url(name)
            url_for(params.merge(name => nil).reverse_merge(:page => 1))
          end
          
          # table sort
          def order_image(field)
            if field == params[:sort]
              order = params[:order] || 'descending'
              order_image = order == 'descending' ? 'arrow_down' : 'arrow_up'
              image_tag "#{order_image}.gif"
            end
          end
        end
        
      end
    end
  end
end