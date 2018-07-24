#此处只做了通用库的依赖，如果业务有相关依赖的关系，请自己后面添加
#-----------------浙江网仓科技有限公司-------------------

Pod::Spec.new do |s|
  s.name             = 'XXStackView'
  s.version          = '1.1.0'
  s.summary          = 'A short description of XXStackView.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://bitbucket.wwwarehouse.com/projects/XDWIOS/repos/XXStackView/browse'
  s.license          = 'MIT'
  s.author           = { 'shichang.wang' => 'shichang.wang@wwwarehouse.com' }
  s.source           = { :git => 'ssh://git@192.168.6.115:7999/xdwios/XXStackView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = 'XXStackView/Classes/**/*.{h,m}'
# s.resources = 'XXStackView/Assets/XXStackView.xcassets'

    s.dependency "SAKit"
    s.dependency "SANetwork"
    s.dependency "SAConfig"
    s.dependency "SALocalizable"
    s.dependency "SAModuleService"
    s.dependency "SAGlobal"
    s.dependency "SANetworkHUD"
#   s.dependency "SASocial"
    s.dependency "SASpecialRequest"
#    s.dependency "SAAudio"
#   s.dependency "SAHardware"

end
