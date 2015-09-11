class ProtectedResourceController < ApplicationController
  before_filter :require_login
end
