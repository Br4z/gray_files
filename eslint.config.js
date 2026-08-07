const globals = {
  __dirname: 'readonly',
  __filename: 'readonly',
  Buffer: 'readonly',
  clearImmediate: 'readonly',
  console: 'readonly',
  exports: 'readonly',
  global: 'readonly',
  module: 'readonly',
  process: 'readonly',
  queueMicrotask: 'readonly',
  require: 'readonly',
  setImmediate: 'readonly',
};

const sharedRules = {
  camelcase: ['error', { properties: 'never' }],
  eqeqeq: ['error', 'always'],
  'no-var': 'error',
  'prefer-const': 'error',
  'object-shorthand': 'error',
  'no-param-reassign': 'error',
  'no-shadow': 'error',
  'consistent-return': 'error',
  'prefer-template': 'error',
  'no-cond-assign': 'error',
  'no-dupe-args': 'error',
  'no-dupe-keys': 'error',
  'no-func-assign': 'error',
  'no-invalid-this': 'error',
  'no-redeclare': 'error',
  'no-sparse-arrays': 'error',
  'no-undef': 'error',
  'no-unreachable': 'error',
  'no-unused-vars': ['error', { argsIgnorePattern: '^_', varsIgnorePattern: '^_' }],
  'no-unsafe-finally': 'error',
  'use-isnan': 'error',
  'valid-typeof': 'error',
};

export default [
  {
    ignores: ['**/node_modules/**', '**/dist/**', '**/build/**', '**/coverage/**'],
  },
  {
    files: ['**/*.{js,mjs}'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals,
    },
    rules: sharedRules,
  },
];
