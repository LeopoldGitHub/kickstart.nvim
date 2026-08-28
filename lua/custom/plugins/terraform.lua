return {
  'allaman/tf.nvim',
  ---@module "tf"
  ---@type tf.ConfigPartial
  opts = {
    terraform = {
      bin = 'tofu',
    },
  },
  ft = { 'terraform', 'hcl' },
}
