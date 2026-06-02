# 2026-05-28T16:25:53.658034
import vitis

client = vitis.create_client()
client.set_workspace(path="ws")

platform = client.get_component(name="gb1b")
status = platform.build()

comp = client.get_component(name="iic_test")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

vitis.dispose()

