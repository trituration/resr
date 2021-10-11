# Restriction Enzyme Sites Removing (RESR)

## Introduction
This program for this...

## Requirements

PYTHON:
  * BioPython: `pip install biopython`

## Installation

```
Пока нет. Если что удалите и напишите, что просто кллонирование и запуск из той же директории куда клонировали
git clone https://github.com/trituration/resr.git  
cd resr/  
pip install -e .  
```

## Usage
The command `resr.py -h` return:

```
usage: program.py [-h]
                  {codon_tables,enzymes,find_known_sites,find_by_pattern,remove_sites,remove_by_pattern}
                  ...

positional arguments:
  {codon_tables,enzymes,find_known_sites,find_by_pattern,remove_sites,remove_by_pattern}
                        Available commands:
    codon_tables        Return avalibale codon tables in STDOUT
    enzymes             Return avalibale restriction enzymes in STDOUT
    find_known_sites    Find sites in fasta file for given restriction enzyme
    find_by_pattern     Find sites in fasta file for given restriction enzyme
    remove_sites        Return modified FASTA
    remove_by_pattern   Return modified FASTA

optional arguments:
  -h, --help            show this help message and exit
```
Программу нужно запускать из рабочей директории и рядом с исполняемым файлом должен находиться restriction_enzymes_database.tsv

Удаление сайтов рестрикции выполняется в несколько этапов: поиск всех сайтов, выбор пользователем сайтов на удаление, удаление сайтов  

### подготовительный этап

Разные организмы имеют немного отличающуюся таблицу кодировку. Возможные варианты достуные для пользователя можно получить следующей командой:

```
python program.py codon_tables
```

Которая возвращает таблицу:
```
The Standard Code 1
The Vertebrate Mitochondrial Code 2
The Yeast Mitochondrial Code 3
The Mold, Protozoan, and Coelenterate Mitochondrial Code and the Mycoplasma/Spiroplasma Code 4
The Invertebrate Mitochondrial Code 5
The Ciliate, Dasycladacean and Hexamita Nuclear Code 6
The Echinoderm and Flatworm Mitochondrial Code 9
The Euplotid Nuclear Code 10
The Bacterial, Archaeal and Plant Plastid Code 11
The Alternative Yeast Nuclear Code 12
The Ascidian Mitochondrial Code 13
The Alternative Flatworm Mitochondrial Code 14
Chlorophycean Mitochondrial Code 16
Trematode Mitochondrial Code 21
Scenedesmus obliquus Mitochondrial Code 22
Thraustochytrium Mitochondrial Code 23
Rhabdopleuridae Mitochondrial Code 24
Candidate Division SR1 and Gracilibacteria Code 25
Pachysolen tannophilus Nuclear Code 26
Karyorelict Nuclear Code 27
Condylostoma Nuclear Code 28
Mesodinium Nuclear Code 29
Peritrich Nuclear Code 30
Blastocrithidia Nuclear Code 31
Cephalodiscidae Mitochondrial UAA-Tyr Code 33
```
Число после имени кодировки пользователь должен выбрать в качестве входного параметра при запуске других праграмм, по умолчанию данный параметр всегда будет 1, т.е. The Standard Code

Второе с чем необходимо определиться это сайт рестриции / рестриктаза
В программе используется БД (Гоша напиши какая и дай ссылку).
Список доступных ретриктаз и их сайтов можно введя команду:

```
python program.py enzymes
```

### поиск всех сайтов рестрикции

Для того чтобы найти сайты можно использовать одну из двух команд.
Первые это find_known_sites либо find_by_pattern.
find_known_sites используется, если пользователь знает рестриктазу с которой он работает, например:
```
python program.py find_known_sites ./NC_005816.fna YenBI test.txt
```
Где `./NC_005816.fna` - фходная фаста, `YenBI` - имя фермента, `test.txt` - выходной файл
find_by_pattern используется в том случае, если пользователь хочет использовать заданый паттерн сайта рестрицкии, например:
```
python program.py find_by_pattern ./NC_005816.fna AGCCAG test.txt
```
Где `./NC_005816.fna` - фходная фаста, `AGCCAG` - паттерн фермента, `test.txt` - выходной файл

В качестве дополнительных параметров используются:

```
-m MIN, --min MIN - Это минимальная длина белка, которы предсказываются в ДНК
-c CODONE, --codone CODONE - Индекс таблицы кодонов
```
  

### выбор пользователем сайтов на удаление

После запсука команд пользователь получет таблицу (в примере как  `test.txt`), например:
```
pos strand  site  region  codone_pos
6899  + GGATCC  in_coding_region  6900
7312  + GGATCC  in_noncoding_region  7312
```
где `pos`  - начало старта рестрикции, `region` - параметр, который показывает находится ли сайт в белок кодирующей последовательности или нет.
Из данной таблицы пользователь модет удалить те строки, для сатов, которые он хочет оставить.
Оставшиеся будут удалены из последовательности.

### удаление сайтов  

Для того чтобы удалить сайты можно использовать одну из двух команд (remove_known_sites/remove_by_pattern). В зависимости от той, что использовали для поиска.
Например:
```
python program.py remove_by_pattern ./NC_005816.fna test.txt AGCCAG new_fasta.fa
```
где `./NC_005816.fna` - тот же фаста файл, что и при использовании команды `python program.py find_by_pattern`, `test.txt` - выходной файл `python program.py find_by_pattern` который при необходимости поправил пользователь. `AGCCAG`  - паттерн, такой же, что и при запуске `python program.py find_by_pattern`. `new_fasta.fa` - последовательность, где необходимые сайты изменены

И пример для другой команды:
```
python program.py remove_known_sites ./NC_005816.fna test.txt YenBI new_fasta.fa
```
где `./NC_005816.fna` - тот же фаста файл, что и при использовании команды `python program.py find_known_sites`, `test.txt` - выходной файл `python program.py find_known_sites` который при необходимости поправил пользователь. `YenBI`  - имя фермента такое же, что и при запуске `python program.py find_known_sites`. `new_fasta.fa` - последовательность, где необходимые сайты изменены

