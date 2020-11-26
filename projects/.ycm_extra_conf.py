def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [ '-x', '-Wall', '-Wextra', '-Werror', '-std=c++17' ],
  }
