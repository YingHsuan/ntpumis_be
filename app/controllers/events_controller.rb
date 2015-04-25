class EventsController < ApplicationController
  require 'ntpumis_logger'
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_event, only:[:edit, :show, :update, :destroy]
  EVENT_TYPE ={
    :domestic => "所上活動",
    :lecture => "專題演講"
  }
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @events_domestic = []
    @events_lecture = []
    events = Event.order("created_at DESC").all
    events.each do |e|
      if e.event_type == "domestic"
        @events_domestic << e
      elsif e.event_type == "lecture"
        @events_lecture << e
      end

    end
  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event = Event.new
    @event_type = EVENT_TYPE.as_json
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event = Event.new(event_params)
    @event.save

    redirect_to :action => :index
    flash[:notice] = "成功新增活動 #{@event.title}"
  end

  def show
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event_type = JSON.parse(JSON[EVENT_TYPE])
  end
  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event_type = JSON.parse(JSON[EVENT_TYPE])
  end

  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event.update(event_params)

    redirect_to :action => :show, :id=>@event
    flash[:notice] = "成功更新活動 #{@event.title}"

  end
  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @event.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除活動 #{@event.title}"
  end
  #API
  def list
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    result = Array.new
    events = Event.order('created_at DESC').all
    events.each do |e|
      result.push(
        {
          :id => e.id,
          :title => e.title,
          :description => e.content,
          :event_type => EVENT_TYPE.as_json[e.event_type],
          :start_time => e.start_time.strftime("%Y/%m/%d %H:%M"),
          :end_time => e.end_time.strftime("%Y/%m/%d %H:%M"),
          :start => e.start_time.strftime("%Y/%m/%d %H:%M"),
          :end => e.end_time.strftime("%Y/%m/%d %H:%M"),
          :created_at => e.created_at.strftime("%Y/%m/%d"),
          :location => e.location
        }


       )
    end
    render :json => result
  end
  private
  def event_params
    params.require(:event).permit(:title,:content,:start_time,:end_time,:event_type,:location)
  end
  def find_event
    @event = Event.find(params[:id])
  end
end
