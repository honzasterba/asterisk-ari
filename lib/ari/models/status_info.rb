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
  class StatusInfo < Model

    attr_reader :startup_time, :last_reload_time

    def startup_time=(val)
      @startup_time ||= Time.parse(val)
    end

    def last_reload_time=(val)
      @last_reload_time ||= Time.parse(val)
    end

  end
end
