module.exports = {
  'parser': '@typescript-eslint/parser',
  'parserOptions': {
    'project': './tsconfig.json',
  },
  'env': {
    'browser': true,
    'node': true,
  },
  'rules': {
    'quotes': ['error', 'single'],
    'semi': ['error', 'always'],
  },
  'extends': ['plugin:@typescript-eslint/recommended'],
}
