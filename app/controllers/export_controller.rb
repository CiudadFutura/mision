class ExportController < ApplicationController
  def index
    respond_to do |format|

      format.pdf do
        pdf = ExportPdf.new(data, c)
        send_data pdf.render,
                  filename: "export.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end
end