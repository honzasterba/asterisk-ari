#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using asterisk-ari-client ruby gem.
#
#------------------------------------------------------------------------------

module Ari
  class ContactStatusChange < Event

    attr_reader :endpoint, :contact_info

    def endpoint=(val)
      @endpoint ||= Endpoint.new(val)
    end

    def contact_info=(val)
      @contact_info ||= ContactInfo.new(val)
    end

  end
end
