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
  class RecordingStarted < Event

    attr_reader :recording

    def recording=(val)
      @recording ||= LiveRecording.new(val)
    end

  end
end
