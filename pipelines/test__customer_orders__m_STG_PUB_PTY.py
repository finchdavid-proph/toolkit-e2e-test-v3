from prophecy_pipeline_sdk.graph import *
from prophecy_pipeline_sdk.properties import *
args = PipelineArgs(label = "test__customer_orders__m_STG_PUB_PTY", version = 1, auto_layout = False)

with Pipeline(args) as pipeline:
    test__customer_orders__m_STG_PUB_PTY__main = Process(
        name = "test__customer_orders__m_STG_PUB_PTY__main",
        properties = ModelTransform(modelName = "test__customer_orders__m_STG_PUB_PTY__main"),
        input_ports = ["in_0", "in_1"]
    )

