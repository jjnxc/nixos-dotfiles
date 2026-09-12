{
  # Sized for the RTX 3070's 8 GB: both models stay resident in VRAM
  # (3.4 GB + 1.0 GB) alongside the desktop, so no CPU offload. qwen3.6 and
  # gemma4 have no variant that fits. Agents need tool calling, which both
  # of these support.
  default = "qwen3.5:4b";
  small = "qwen3.5:0.8b";
  contextLength = 32768;
}
