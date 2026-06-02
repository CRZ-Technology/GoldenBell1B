# 2026-05-28T13:53:10.362826700
import vitis

client = vitis.create_client()
client.set_workspace(path="ws")

advanced_options = client.create_advanced_options_dict(dt_overlay="0")

platform = client.create_platform_component(name = "gb1b",hw_design = "$COMPONENT_LOCATION/../../design_1_wrapper.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0",generate_dtb = False,advanced_options = advanced_options,compiler = "gcc")

platform = client.get_component(name="gb1b")
status = platform.build()

comp = client.create_app_component(name="iic_test",platform = "$COMPONENT_LOCATION/../gb1b/export/gb1b/gb1b.xpfm",domain = "standalone_microblaze_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="iic_test")
comp.build()

status = platform.build()

comp.build()

client.delete_component(name="iic_test")

client.delete_component(name="componentName")

comp = client.create_app_component(name="iic_test",platform = "$COMPONENT_LOCATION/../gb1b/export/gb1b/gb1b.xpfm",domain = "standalone_microblaze_0",template = "empty_application")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

