module TableHeader
  module App
    module Controllers
      module ApplicationController
  
        def self.included(base)
          base.class_eval do
            include InstanceMethods
            extend ClassMethods
          end
        end
        
        module ClassMethods
          def selectable_attributes(*args)
            mappings           = pop_hash_from_list(args)
            acceptable_columns = join_array_and_hash_keys(args, mappings)
            
            define_method(:select_conditions) do |*default| 
              conditions = []
              params.keys.each do |name|
                if acceptable_columns.include?(name) && !params[name].blank?
                  conditions << ["#{name} = '#{params[name]}'"]
                end
              end
              conditions
            end
          end
          
          def filter_attributes(*args)
            mappings           = pop_hash_from_list(args)
            acceptable_columns = join_array_and_hash_keys(args, mappings)
            
            define_method(:filter_conditions) do |*default| 
              conditions = []
              params.keys.each do |name|
                if acceptable_columns.include?(name) && !params[name].blank?
                  conditions << ["#{name.downcase} LIKE '%#{params[name]}%'"]
                end
              end
              conditions
            end
          end
          
        end

        module InstanceMethods
          
        end
      end
    end
  end  
end


