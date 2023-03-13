class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /documents or /documents.json
  def index
    @documents = Document.where(is_private: false).where.not(user_id:current_user.id)
  end

  def my_document
    @documents = Document.where(user_id: current_user.id)
  end

  def copy_document
  
    old_file = Document.find(params[:copy_document_id])    
    new_file = old_file.dup
    new_file.user_id = current_user.id
    new_file.is_owner = false
    new_file.save

    old_attachments = ActiveStorage::Attachment.where(record_id:params[:copy_document_id])

    old_attachments.each do |old_attachment|
    ActiveStorage::Attachment.create(
      name: old_attachment.name,
      record_type: old_attachment.record_type,
      record_id: new_file.id,
      blob_id: old_attachment.blob_id
      )
    end
    respond_to do |format|  format.html { redirect_to request.referer, notice: 'Copied Files!' } end

  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to document_url(@document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:name, :is_private, :is_owner, :user_id, images: [])
    end
end
