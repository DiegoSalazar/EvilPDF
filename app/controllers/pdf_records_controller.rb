class PdfRecordsController < ApplicationController
  # GET /pdf_records
  # GET /pdf_records.json
  def index
    @pdf_records = PdfRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pdf_records }
    end
  end

  # GET /pdf_records/1
  # GET /pdf_records/1.json
  def show
    @pdf_record = PdfRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pdf_record }
    end
  end

  # GET /pdf_records/new
  # GET /pdf_records/new.json
  def new
    @pdf_record = PdfRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pdf_record }
    end
  end

  # GET /pdf_records/1/edit
  def edit
    @pdf_record = PdfRecord.find(params[:id])
  end

  # POST /pdf_records
  # POST /pdf_records.json
  def create
    @pdf_record = PdfRecord.new(params[:pdf_record])
    @pdf_record.pdf_from_urls
    
    respond_to do |format|
      if @pdf_record.save
        format.html { redirect_to @pdf_record, notice: 'Pdf record was successfully created.' }
        format.json { render json: @pdf_record, status: :created, location: @pdf_record }
      else
        format.html { render action: "new" }
        format.json { render json: @pdf_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pdf_records/1
  # PUT /pdf_records/1.json
  def update
    @pdf_record = PdfRecord.find(params[:id])

    respond_to do |format|
      if @pdf_record.update_attributes(params[:pdf_record])
        format.html { redirect_to @pdf_record, notice: 'Pdf record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pdf_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pdf_records/1
  # DELETE /pdf_records/1.json
  def destroy
    @pdf_record = PdfRecord.find(params[:id])
    @pdf_record.destroy

    respond_to do |format|
      format.html { redirect_to pdf_records_url }
      format.json { head :no_content }
    end
  end
end
