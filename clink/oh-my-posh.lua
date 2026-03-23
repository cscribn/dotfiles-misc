os.setenv("LEADING_SYMBOL", "(")
os.setenv("TRAILING_SYMBOL", ")")
load(io.popen('oh-my-posh init cmd --config ~/.config/oh-my-posh/themes/powerlevel10k_amped_rainbow.omp.json'):read("*a"))()
