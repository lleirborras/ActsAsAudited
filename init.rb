# Include hook code here
require File.dirname(__FILE__) + '/lib/active_record/acts/audited.rb'

ActiveRecord::Base.send :include, ActiveRecord::Acts::Audited
