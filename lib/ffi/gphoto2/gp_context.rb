module FFI
  module GPhoto2
    class GPContext < FFI::Struct
      # libgphoto2/gphoto2-context.c
      layout :idle_func, :pointer, # GPContextIdleFunc
             :idle_func_data, :pointer, # void*

             :progress_start_func, :pointer, # GPContextProgressStartFunc
             :progress_update_func, :pointer, # GPContextProgressUpdateFunc
             :progress_stop_func, :pointer, # GPContextProgressStopFunc
             :progress_func_data, :pointer, # void*

             :error_func, :pointer, # GPContextErrorFunc
             :error_func_data, :pointer, # void*

             :question_func, :pointer, # GPContextQuestionFunc
             :question_func_data, :pointer, # void*

             :cancel_func, :pointer, # GPContextCancelFunc
             :cancel_func_data, :pointer, # void*

             :status_func, :pointer, # GPContextStatusFunc
             :status_func_data, :pointer, # void*

             :message_func, :pointer, # GPContextMessageFunc
             :message_func_data, :pointer, # void*

             :ref_count, :uint
    end
  end
end
