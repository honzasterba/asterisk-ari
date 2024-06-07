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
  class ConfigInfo < Model

    attr_reader :name, :default_language, :max_channels, :max_open_files, :max_load, :setid

    def max_load=(val)
      @max_load ||= double.new(val)
    end

    def setid=(val)
      @setid ||= SetId.new(val)
    end

  end
end
