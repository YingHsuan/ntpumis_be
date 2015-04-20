class TeachersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  require 'setting'
  require 'ntpumis_logger'
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teachers = Teacher.all
    @title_array_c = Setting::TEACHER_TITLE_ARRAY_C
  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher = Teacher.new
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher =  Teacher.new(teacher_params)
    @teacher.save

    redirect_to :action => :index
    flash[:notice] = "成功新增老師 #{@teacher.name_c}"

  end

  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher = Teacher.find(params[:id])
    @teacher.update(teacher_params)

    redirect_to :action => :show, :id => @teacher
    flash[:notice] = "成功更新老師"

  end
  def show
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher = Teacher.find(params[:id])
    @employ_type_array = Setting::TEACHER_EMPLOY_TYPE
    @title_array_c = Setting::TEACHER_TITLE_ARRAY_C
  end
  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher = Teacher.find(params[:id])
  end
  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除老師"

  end
# API
  def list

    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    data = JSON.parse(request.body.read)
    result = Array.new
    title_array_c = Setting::TEACHER_TITLE_ARRAY_C
    title_array_e = Setting::TEACHER_TITLE_ARRAY_E
    teachers = Teacher.where("isShow = ?",true)
    teachers.each do |teacher|
      if data['locale'] == 'en'
        result.push(
            {
              :id => teacher.id,
              :name => teacher.name_e,
              :office => teacher.office_e,
              :domain => teacher.domain_e,
              :degree => teacher.degree_e,
              :title => title_array_e[teacher.title_priority],
              :title_priority => teacher.title_priority,
              :is_chair => teacher.is_chair,
              :email => teacher.email,
              :tel => teacher.tel,
              :extension => teacher.extension,
              :employ_type => teacher.employ_type,
              :image_url => teacher.image_url
            }
          )
      else
        result.push(
            {
              :id => teacher.id,
              :name => teacher.name_c,
              :office => teacher.office_c,
              :domain => teacher.domain_c,
              :degree => teacher.degree_c,
              :title => title_array_c[teacher.title_priority],
              :title_priority => teacher.title_priority,
              :is_chair => teacher.is_chair,
              :email => teacher.email,
              :tel => teacher.tel,
              :extension => teacher.extension,
              :employ_type => teacher.employ_type,
              :image_url => teacher.image_url

            }
          )
      end
    end
    render :json => result

  end

  def create_api
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    data = JSON.parse(request.body.read)
    puts data.to_s

    teacher = Teacher.new
    teacher.transaction do
      teacher.name_c = data['name_c']
      teacher.name_e = data['name_e']
      teacher.office_c = data['office_c']
      teacher.office_e = data['office_e']
      teacher.domain_c = data['domain_c']
      teacher.domain_e = data['domain_e']
      teacher.degree_c = data['degree_c']
      teacher.degree_e = data['degree_e']
      teacher.title_priority = data['title_priority']
      teacher.is_chair = data['is_chair']
      teacher.email = data['email']
      teacher.tel = data['tel']
      teacher.extension = data['extension']
      teacher.employ_type = data['employ_type']
      teacher.image_url = data['image_url']

      teacher.save!
    end
    result =
      {
       :status => 'success',
       :id => teacher.id,
       :createTime => teacher.created_at
      }
    render :json => result
  end

  def update_api
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    teacher = Teacher.find_by_id(params[:teacherId])
    if teacher.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      data = JSON.parse(request.body.read)
      puts data.to_s

      teacher.name_c = data['name_c']
      teacher.name_e = data['name_e']
      teacher.office_c = data['office_c']
      teacher.office_e = data['office_e']
      teacher.domain_c = data['domain_c']
      teacher.domain_e = data['domain_e']
      teacher.degree_c = data['degree_c']
      teacher.degree_e = data['degree_e']
      teacher.title_priority = data['title_priority']
      teacher.is_chair = data['is_chair']
      teacher.email = data['email']
      teacher.tel = data['tel']
      teacher.extension = data['extension']
      teacher.employ_type = data['employ_type']
      teacher.image_url = data['image_url']
      teacher.save!

      render :json =>{
        :id => teacher.id,
        :status => 'successfully updated'
      }
    end
  end
  def delete
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    teacher = Teacher.find_by_id(params[:teacherId])
    if teacher.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      puts "Teacher id :#{teacher.id} DELETED"
      teacher.destroy
      render :json =>{
        :status => "success"
      }
    end
  end
  private
  def teacher_params
    params.require(:teacher).permit(:name_c, :name_e, :office_c, :office_e, :domain_c, :domain_e, :degree_c, :degree_e, :title_priority, :is_chair, :email, :tel, :extension ,:employ_type, :image_url,:isShow)
  end

end
