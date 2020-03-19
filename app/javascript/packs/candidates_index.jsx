import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import { DragDropContext } from 'react-beautiful-dnd'
import PropTypes from 'prop-types'
import consumer from '../channels/consumer'
import CardBoard from './CardBoard'

const CandidatesIndex = () => {
  const [data, setData] = useState(null)

  useEffect(() => {
    async function fetchData() {
      await fetch('/candidates.json')
      .then(res => res.json())
      .then(res => {setData(res)})
    }

    fetchData()
  }, [])

  if(!data) { return(null) }

  // Sub to backend websocket
  consumer.subscriptions.create("CandidatesChannel", {
    connected() { console.log('Connected to candidates channel !') },
    received(data) {
      const updatedCandidate = data.updatedCandidate

      updateCandidate(updatedCandidate)
    }
  });

  const updateCandidate = (updatedCandidate) => {
    setData({
      status:     data.status,
      candidates: data.candidates.map((candidate) => {
        if(candidate.id === updatedCandidate.id) {
          candidate.status = updatedCandidate.status
        }

        return(candidate)
      })
    })
  }

  const onDragEnd = result => {
    const { destination, source, draggableId } = result

    if(!destination) { return; }

    if(
      destination.droppableId === source.droppableId &&
      destination.index === source.index
    ) { return; }

    let candidateToUpdate = { id: draggableId, status: destination.droppableId }

    updateCandidate(candidateToUpdate)
    fetch(`/update_status/${candidateToUpdate.id}/${candidateToUpdate.status}`, { method: 'post' })
  }

  const statusValues = Object.values(data.status)
  const statusTrad   = Object.keys(data.status)

  return(
    <DragDropContext onDragEnd={onDragEnd}>
      <div className='candidates-react-component'>
        {
          statusValues.map((status, index) => {
            return(
              <CardBoard
                title={statusTrad[index]}
                statusValue={status}
                candidates={data.candidates.filter((candidate) => { return(candidate.status === status) })}
                key={index}
              />
            )
          })
        }
      </div>
    </DragDropContext>
  )
}

CandidatesIndex.propTypes = { name: PropTypes.string }

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <CandidatesIndex name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
