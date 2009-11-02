# ActsAsAudited
module ActiveRecord
  module Acts
    module Audited
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_audited(options = {})
          configuration = {:user => "user", :user_id => "user_id", :user_class => "User", :current_user => "current_user"}
          configuration.update(options) if options.is_a?(Hash)

          class_eval <<-EOV
            include ActiveRecord::Acts::Audited::InstanceMethods

            belongs_to :#{configuration[:user]}

            before_validation :update_user

            validates_presence_of :#{configuration[:user]}

            private
              def update_user
                self.#{configuration[:user_id]} = #{configuration[:user_class]}.#{configuration[:current_user]}.id unless #{configuration[:user_class]}.#{configuration[:current_user]}.nil?
              end

            public
          EOV
        end
      end

      module InstanceMethods
      end
    end
  end
end

