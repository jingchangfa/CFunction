#!/usr/bin/ruby

  def start_create
    p '输入文件名称:'
    file_name = gets.chomp
    cf_ruby_create_oc(file_name)
  end

  def cf_ruby_create_oc name
    dir_path = Dir.pwd
    controlelr_dir_path = dir_path + '/' + cf_dir_name(name)
    # 创建文件夹
    Dir.mkdir(controlelr_dir_path)
    # 创建view文件
    view_h_file = File.open(cf_view_file_h(name, controlelr_dir_path), 'w:UTF-8')
    view_m_file = File.open(cf_view_file_m(name, controlelr_dir_path), 'w:UTF-8')
    # 创建controlelr文件
    controller_h_file = File.open(cf_controller_file_h(name, controlelr_dir_path), 'w:UTF-8')
    controller_m_file = File.open(cf_controller_file_m(name, controlelr_dir_path), 'w:UTF-8')
    # view.h 写入内容
    view_h_content_write name,view_h_file, dir_path
    # view.m 写入内容
    view_m_content_write name, view_m_file, dir_path
    # controller.h 写入内容
    controller_h_content_write name, controller_h_file, dir_path
    # controller.m 写入内容
    controller_m_content_write name, controller_m_file, dir_path
    # 保存文件
    view_h_file.close
    view_m_file.close
    controller_h_file.close
    controller_m_file.close
  end
  # 文件名 以及 路径相关
  def cf_dir_name name
    name + 'Controller'
  end

  def cf_view_file_h name, controller_floder_path
    controller_floder_path + '/' + name + 'BackView.h'
  end

  def cf_view_file_m name, controller_floder_path
    controller_floder_path + '/' + name + 'BackView.m'
  end

  def cf_controller_file_h name, controller_floder_path
    controller_floder_path + '/' +  name + 'ViewController.h'
  end

  def cf_controller_file_m name, controller_floder_path
    controller_floder_path + '/' + name + 'ViewController.m'
  end
  # 文件的读写 相关
  def view_h_content_write name,file,dir_path
    stencil_view_h_path = dir_path + '/' + 'StencilBackView.h'
    content_string = stencil_content_change stencil_view_h_path, name
    file.puts content_string
  end

  def view_m_content_write name,file,dir_path
    stencil_view_m_path = dir_path + '/' + 'StencilBackView.m'
    content_string = stencil_content_change stencil_view_m_path, name
    file.puts content_string
  end

  def controller_h_content_write name,file,dir_path
    stencil_controller_h_path = dir_path + '/' + 'StencilViewController.h'
    content_string = stencil_content_change stencil_controller_h_path, name
    file.puts content_string
  end

  def controller_m_content_write name,file,dir_path
    stencil_controller_m_path = dir_path + '/' + 'StencilViewController.m'
    content_string = stencil_content_change stencil_controller_m_path, name
    file.puts content_string
  end

  # 读取并替换 file内容
  def stencil_content_change filePath, name
    file = File.open(filePath, 'rb:UTF-8')
    contents = file.read
    file.close
    contents.gsub('Stencil', name)
  end
   

  start_create
