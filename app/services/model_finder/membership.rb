module ModelFinder
  class Membership < Finder
    def find_or_initialize
      ::Membership.find_or_initialize_by(
        user: info['user'],
        joinable: info['joinable']
      ).tap do |membership|
        update(membership)
      end
    end
  end
end
