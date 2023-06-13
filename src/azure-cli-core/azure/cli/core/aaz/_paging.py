# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
import itertools
import logging

_LOGGER = logging.getLogger(__name__)


class AAZPageIterator:
    def __init__(self, executor, extract_result, next_link, did_once_already, total_len):
        self._executor = executor
        self._extract_result = extract_result
        self._next_link = next_link
        self._did_once_already = did_once_already
        self._total_len = total_len
        self._prev_link = None
        self._page_size = None

    def __iter__(self):
        return self

    def __next__(self):
        if self._total_len < 0:
            _LOGGER.warning(f"Token of next page: {self._prev_link},{self._page_size + self._total_len}.")
            raise StopIteration

        if not self._next_link and self._did_once_already:
            raise StopIteration(f"End of paging.")

        self._executor(self._next_link)
        self._did_once_already = True
        self._prev_link = self._next_link
        curr_page, self._next_link = self._extract_result()

        self._page_size = len(curr_page)
        self._total_len -= self._page_size

        return iter(curr_page[:self._total_len]) if self._total_len < 0 else iter(curr_page)


class AAZPaged:
    def __init__(self, executor, extract_result, page_size, next_token):
        self._page_iterator = itertools.chain.from_iterable(
            AAZPageIterator(
                executor=executor,
                extract_result=extract_result,
                next_link=None,
                did_once_already=False,
                total_len=2
            )
        )

    def __repr__(self):
        return "<iterator object azure.cli.core.aaz.paging.AAZPaged at {}>".format(hex(id(self)))

    def __iter__(self):
        return self

    def __next__(self):
        return next(self._page_iterator)
