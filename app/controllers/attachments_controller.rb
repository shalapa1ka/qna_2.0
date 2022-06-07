# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:attachment_id])
    flash[:notice] = 'Attachment file successfully deleted!' if @attachment.destroy
  end
end
