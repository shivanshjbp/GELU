Fixed-Point GELU Activation Design for ML Accelerators
A hardware-efficient, pipelined implementation of the GELU (Gaussian Error Linear Unit) activation function for quantized transformer accelerators.
This module approximates the GELU nonlinearity using a symmetric piecewise-polynomial method, enabling integer-only execution for 8-bit or low-precision inputs. Designed for use in the feed-forward layers of transformer architectures targeting edge AI applications.
