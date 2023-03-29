module Coderberry
  class Utils
    # @param [ActiveRecord::Base] klass
    def active_record_callbacks(klass)
      klass.__callbacks.each_with_object(Hash.new([])) do |(k, callbacks), result|
        next if k == :validate # ignore validations

        callbacks.each do |c|
          # remove autosaving callbacks from result
          next if c.filter.to_s.include?("autosave")
          next if c.filter.to_s.include?("_ensure_no_duplicate_errors")

          result["#{c.kind}_#{c.name}"] += [c.filter]
        end
      end

    end
  end
end