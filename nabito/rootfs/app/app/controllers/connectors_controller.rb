class ConnectorsController < ApplicationController
  before_action :set_connector,
                only: %i[show edit update destroy switch_on switch_off sync]
  before_action :authenticate_user!

  def switch_on
    # return unless user_approved
    @connector.switch_on(current_user) if switch_on_check

    redirect_to @connector # notice: 'El socket was successfully created.' 
  end

  def switch_off
    # return unless user_approved
    @connector.switch_off(current_user) if switch_off_check

    redirect_to @connector
  end

  def sync
    if Time.now.utc - @connector.last_timestamp > 60.seconds
      ConnectorRequestJob.perform_later(@connector.ping_topic,
                                        @connector.frequency)
      ConnectorSyncJob.perform_later(@connector.id)
    end
    redirect_to @connector
  end

  # GET /connectors
  # GET /connectors.json
  def index
    @connectors = Connector.all
  end

  # GET /connectors/1
  # GET /connectors/1.json
  def show
    # @connector.mqtt_refresh_state()
    # @connector.sync_state()
    # MqttRequestJob.perform_later(@connector)

  end

  # GET /connectors/new
  def new
    @connector = Connector.new
  end

  # GET /connectors/1/edit
  def edit
  end

  # POST /connectors
  # POST /connectors.json
  def create
    @connector = Connector.new(connector_params)
    @connector.user_id = current_user.id

    respond_to do |format|
      if @connector.save
        format.html { redirect_to @connector, notice: 'Connector was successfully created.' }
        format.json { render :show, status: :created, location: @connector }
      else
        format.html { render :new }
        format.json { render json: @connector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connectors/1
  # PATCH/PUT /connectors/1.json
  def update
    respond_to do |format|
      if @connector.update(connector_params)
        format.html { redirect_to @connector, notice: 'Connector was successfully updated.' }
        format.json { render :show, status: :ok, location: @connector }
      else
        format.html { render :edit }
        format.json { render json: @connector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connectors/1
  # DELETE /connectors/1.json
  def destroy
    @connector.destroy
    respond_to do |format|
      format.html { redirect_to connectors_url, notice: 'Connector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_connector
    @connector = Connector.find(params[:id])
  end

  def switch_on_check
    if @connector.in_use
      if @connector.current_user == current_user.id
        flash[:notice] = 'Socket already switched on'
      else
        flash[:notice] = 'Socket currently used by a different user'
      end
      return false
    else
      flash[:notice] = 'Socket switched on'
      return true
    end
  end

  def switch_off_check
    if @connector.in_use
      if @connector.current_user == current_user.id
        flash[:notice] = 'Socket switched off'
        return true
      else
        flash[:notice] = 'Socket currently used by a different user'
        return false
      end
    else
      flash[:notice] = 'Socket is already off'
      return false
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def connector_params
    params.require(:connector).permit(:owner, :name, :command_topic, :state_topic, :json_attributes_topic, :payload_on, :payload_off, :state_on, :state_off, :power, :voltage, :i_max, :price_per_kWh, :frequency, :state, :current_user, :current_tnx)
  end
end
