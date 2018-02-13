class ChangeCulumnToTeacherSettings < ActiveRecord::Migration
  def change
    change_column_null :teacher_settings, :message,	:string, false
    change_column_null :teacher_settings, :fee,		:integer, false

    change_column_default :teacher_settings, :message, ''
    change_column_default :teacher_settings, :fee, 0
  end
end
